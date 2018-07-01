# dddb
[![Build Status](https://travis-ci.org/cvsae/dddb.svg?branch=master)](https://travis-ci.org/cvsae/dddb)

 dddb is lightweight and simple key-value dlang database (store) build on top of std.json 

## Usage


``` d


import std.stdio;
import dddb;

void main()
{
	
	auto db = new ddb("yes.db");
    

    // set multiple values to social_networks
    db.set("social_networks", "facebook");
    db.set("social_networks", "twitter");
    db.set("social_networks", "linkedin");

    writeln(db.get("social_networks"));
    // ["facebook", "twitter", "linkedin"]

    writeln(db.count("social_networks"));
    // will return 3, because we have add ["facebook", "twitter", "linkedin"]

    assert(db.count("social_networks") == 3);
    // no error because there are 3 ["facebook", "twitter", "linkedin"]

    db.update("social_networks", "facebook", "instagram");
    // update facebook to instagram 
    writeln(db.get("social_networks"));
    // ["instagram", "twitter", "linkedin"]

    assert(db.countkeys() == 1);
    writeln(db.getkeys()); 
    // db.getkeys() return a list of all keys,
    // ["social_networks"]

    assert(db.getsize() == 54);
    writeln(db.getsize());
    // db.getsize() return the database size in bytes
    // 58
    

    assert(db.havevalue("social_networks", "facebook") == false);
    writeln(db.havevalue("social_networks", "facebook")); // expected false
    // because facebook not exists in social_networks, we update it with instagram in line 240

    assert(db.havevalue("social_networks", "instagram") == true);
    writeln(db.havevalue("social_networks", "instagram")); // expected true 
    // true 


    // db.drop() delete database 
    // NOTE: all db data will be lost
    db.drop();
    assert(exists(db.db) == false);
}
