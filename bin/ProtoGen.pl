#!/usr/bin/perl

# This script takes 2 parameters. Example incovation:
#
#    protobuf.pl D:\some\input\folder\with\proto\files D:\some\output\folder
#
# It will run the protoc code generator on all *.proto files found in the input folder and output C++ code for it.
# You only need this script if your build process does not have native protoc rules built-in.
# This for example is the case for non-cmake generated, hand-written Visual Studio workspaces.
# In that case, you can invoke this perl script to trigger the code generation.

use 5.006_000;
use strict;    

use File::stat;
use File::Basename;
use File::Path;
use File::Spec;
use Cwd;
use Env;

{
   my $argc = $#ARGV+1; 

   $argc==2 || die "Error: This script needs 2 parameters. Invocation: protobuf.pl D:\\some\\input\\folder\\with\\proto\\files D:\\some\\output\\folder\n";
   
   my $indir  = Cwd::abs_path($ARGV[0]);
   my $outdir = $ARGV[1];
   if(! -d $outdir)
   {
      mkpath($outdir);
      (-d $outdir) || die "Error: Cannot create directory $outdir\n";
   }
   $outdir = Cwd::abs_path($outdir);

   my $protoc_exe;
   if($ENV{'OS'} eq "Windows_NT")
   {
      $protoc_exe   = "protoc.exe --error_format=msvs"; # todo: add this option for VS builds only, not for MonoDevelop
   }
   else
   {
      $protoc_exe   = "./protoc";
   }

   opendir(DIR, $indir) or die "Error: Cannot open input directory $indir\n";
   while(my $file1 = readdir(DIR))
   {
      my ($name1, $path1, $suffix1) = fileparse($file1, qr{\.proto$});
      if($suffix1 eq ".proto")
      {
         my $protofile = File::Spec->catfile($indir,  $name1.".proto");
         my $hfile     = File::Spec->catfile($outdir, $name1.".pb.h");     
         my $cppfile   = File::Spec->catfile($outdir, $name1.".pb.cc");     

         my $prototimestamp = stat($protofile)->mtime;
         my $cpptimestamp   = $prototimestamp;
         my $htimestamp     = $prototimestamp;
         if(-e $cppfile)
         {
            $cpptimestamp = stat($cppfile)->mtime;
         }
         if(-e hfile)
         {
            $htimestamp = stat($hfile)->mtime;
         }

         if( ($prototimestamp>=$cpptimestamp) || ($prototimestamp>=$htimestamp) )
         {
            print "Running protobuf code generator $protofile -> $cppfile\n";

            my $cmd = $protoc_exe . " --proto_path=$indir $protofile --cpp_out=$outdir 2>&1";                
            #print "$cmd\n";
            my $result = `$cmd`;
            $result eq "" || print "$result\n";

            (-e $cppfile) || die "Error creating $cppfile\n";
            (-e $hfile)   || die "Error creating $hfile\n";
            my $cpptimestamp_new = stat($cppfile)->mtime;
            my $htimestamp_new   = stat($hfile)->mtime;
            ($cpptimestamp_new > $cpptimestamp) || die "Error creating $cppfile\n";
            ($htimestamp_new   > $htimestamp)   || die "Error creating $hfile\n";
            #print "Successfully created $cppfile\n";
         }
         else
         {
            #print "Code generation from $protofile is not necessary, destination file $cppfile is up to date.\n";
         }
      }
   }
}
