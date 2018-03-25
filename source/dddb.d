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

		if(have(key)){
			return(j[key].str);
		} 
		else{
			throw new Exception("Error: key not exists");
		}			
	}

	void set(string key, string value){
		// set value to specifiec key
        JSONValue j = parseJSON(dbdata);
        if(!have(key)){
        	j.object[key] = value;
        	save(j);
        }
        else{
        	throw new Exception("Error: key already exists");
        }
	}

	
	void update(string key, string value){
		// update an already existed key value with new value
		JSONValue j = parseJSON(dbdata);

		if(have(key)){
			j[key].str = value;
			save(j);
		}
		else{
			throw new Exception("Error: Unable to update key wich not already exists");
		}	
	}

	string[] getkeys(){
		// get keys 
		JSONValue j = parseJSON(dbdata);
		return(j.object.keys);
	}


	int countkeys(){
		// return the lenght of databae keys
		JSONValue j = parseJSON(dbdata);
		return to!int(j.object.keys.length);

	}
	
	int getsize(){
		// return database size in bytes
		if(exists(db)){
			return to!int(getSize(db));
		} else{
			throw new Exception("Error: Unable to get database size, database not exists");
		}
	}


	bool have(string key){
		// return true if key exists false if not
		JSONValue j = parseJSON(dbdata);
		return((key in j) != null);
	}
}
