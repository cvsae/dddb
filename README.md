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
	assert(db.coutkeys()) == 2);
	writeln(db.countkeys()); // 2
	
}
