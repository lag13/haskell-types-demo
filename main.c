#include <stdio.h>
#include <string.h>
#include <stdbool.h>

// A poor man's hash table which is just an array of pairs.
typedef struct {
  char *key;
  int value;
} strIntPair;

typedef struct {
  int len;
  strIntPair *map;
} strToIntMap;

// This looks up the specified key in the hash table. If it is found
// the function will return "true" and populate the "value" variable
// with the value. Otherwise it returns false and does nothing to the
// "value" variable. So the contract this function has with callers is
// that the returned boolean MUST be checked before using the value.
// Failing to do this could introduce some sort of bug.
bool lookup(char *key, strToIntMap m, int *value) {
  for (int i = 0; i < m.len; i++) {
    strIntPair pair = m.map[i];
    if (strcmp(pair.key, key) == 0) {
      *value = pair.value;
      return true;
    }
  }
  return false;
}

void printValueIfKeyExists(char *key, strToIntMap map) {
  bool exists;
  int value;
  exists = lookup(key, map, &value);
  if (exists) {
    printf("at key \"%s\" the value is: %d\n", key, value);
  } else {
    printf("there is no value for key \"%s\"\n", key);
  }
}

int main(int argc, char **argv) {
  strToIntMap map = {
    .len = 4,
    .map = (strIntPair[]){
      {"hello-world", 1},
      {"meaning-of-life", 42},
      {"number-of-lotr-rings", 20},
      {"num-wheel-of-time-books", 14}
    }
  };
  printValueIfKeyExists("hello-world", map);
  printValueIfKeyExists("does-not-exist", map);
  printValueIfKeyExists("meaning-of-life", map);
  // // We see here that the code still compiles and runs even though
  // // we've used the "lookup" function incorrectly (we didn't check the
  // // returned boolean which says if the key exists).
  // int value;
  // char *key = "does-not-exist";
  // lookup(key, map, &value);
  // printf("at key \"%s\" the value is: %d\n", key, value);
}
