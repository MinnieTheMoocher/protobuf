/* the location of <hash_map> */
#define HASH_MAP_H <hash_map>

/* the namespace of hash_map/hash_set */
#ifdef _MSC_VER
	#if _MSC_VER<1310 || _MSC_VER>=1600
		#define HASH_NAMESPACE std
	#else
		#define HASH_NAMESPACE stdext
	#endif
#else
   #error port me!
#endif

/* the location of <hash_set> */
#define HASH_SET_H <hash_set>

/* define if the compiler has hash_map */
#define HAVE_HASH_MAP 1

/* define if the compiler has hash_set */
#define HAVE_HASH_SET 1

/* define if you want to use zlib.  See readme.txt for additional
 * requirements. */
// #define HAVE_ZLIB 1
