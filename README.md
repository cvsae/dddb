# dlogger
 Dddb lightweight and simple key-value store using std.json 

## Usage


``` d


import std.stdio;
import dddb;

void main() {

	auto db = new ddb("social.db");

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
}