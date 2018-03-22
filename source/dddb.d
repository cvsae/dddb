// Copyright (c) 2018 CVSC
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.


import std.conv : to;
import std.stdio;
import std.file;
import std.json;



class ddb{


	string dbdata;
	string db;
	

	this(string dbfile){
		db = dbfile;
	    // :dbfile database filename
	    if(exists(dbfile)) {
	    	// already have dbfile load it 
	    	load();

	    } else{
	    	// db not exists, init null db
	    	dbdata = "{}";
	    }
	}



	void load(){
		// load db contents
		File file = File(db, "r");
	    dbdata = file.readln(); 
	}




	void save(JSONValue data){
		// save 
		File file = File(db, "w+");
		file.write(data);
		file.close();
		load(); // load with the new objects
	}



	string get(string key){
		// return the value of specifiec key
		JSONValue j = parseJSON(dbdata);
		return(j[key].str);
	}

	void set(string key, string value){
		// set value to specifiec key
        JSONValue j = parseJSON(dbdata);
	    j.object[key] = value;
	    save(j);
	}

	
	void update(string key, string value){
		// update an already existed key value with new value
		JSONValue j = parseJSON(dbdata);
		j[key].str = value;
		save(j);
	}

	string[] getkeys(){
		// get keys 
		JSONValue j = parseJSON(dbdata);
		return(j.object.keys);
	}
}



void main() {
	auto db = new ddb("tres.db");
	db.set("facebook", "fb");
	db.set("instagram", "insta");
	db.set("whatsapp", "stspp");

	assert(db.get("facebook") == "fb");
	assert(db.get("instagram") == "insta");
	assert(db.get("whatsapp") == "stspp");

	db.update("facebook", "fatsabook");
	writeln(db.get("facebook"));
	writeln(db.getkeys());
}