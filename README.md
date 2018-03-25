# dddb
[![Build Status](https://travis-ci.org/cvsae/dddb.svg?branch=master)](https://travis-ci.org/cvsae/dddb)

 dddb is lightweight and simple key-value dlang database (store) build on top of std.json 

## Usage


``` d


import std.stdio;
import dddb;

void main() {

	auto db = new ddb("test.db");

        // set facebook value to fb 
	db.set("facebook", "fb");
	// set instagram value to insta
	db.set("instagram", "insta");

        // get facebook value
	writeln(db.get("facebook")); // fb
	// get instagram value
	writeln(db.get("instagram")); // insta

        // assertions
	assert(db.get("facebook") == "fb");
	assert(db.get("instagram") == "insta");
    

        // update facebook value to ffb
	db.update("facebook", "ffb");
	writeln(db.get("facebook")); // ffb

        // db.getkeys() return a list of all keys 
	writeln(db.getkeys()); 
	
	// db.countkeys() return the lenght of databae keys
	assert(db.countkeys() == 2);
	writeln(db.countkeys()); // 2
	
	assert(db.getsize() == 38);
	// db.getsize() return the database size in bytes
	writeln(db.getsize()); // 38
	
	// db.drop() delete database 
	// NOTE: all db data will be lost
	db.drop();
	assert(exists(db.db) == false);
	
	
}
