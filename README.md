# dddb
[![Build Status](https://travis-ci.org/cvsae/dddb.svg?branch=master)](https://travis-ci.org/cvsae/dddb)

 dddb is lightweight and simple key-value dlang database (store) build on top of [std.json](https://dlang.org/phobos/std_json.html) 

## Usage





# dddb

```D
import std.stdio;
import dddb;

void main()
{
   // open a connection to database
   auto db = new ddb("test.db");
   // set value to specific key
   db.set("hello", "world");
   // read the value of the specific key
   writeln(db.get("hello")); // world
}


```



## Documantation
* SET key value → Set the value of a str key |→ Return Boolean
* GET key → Get the value of a key |→ Return String
* GETKEYS → Return all values from database |→ Return Array
* HAVEVALUE key VALUE → Determine if the value exists in the given key |→ Return Boolean
* HAVEKEY key → Determine if the key exists |→ Return Boolean
* COUNTKEYS → Return the length of keys |→ Return Integer
* GETSIZE → Return the size of database (bytes) |→ Return Integer
* DROP → Delete everything from the database |→ Return Boolean
