// Copyright (c) 2018 CVSC
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import std.conv : to;
import std.stdio;
import std.file;
import std.json;


class ddb{

    
    JSONValue j;
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
	    	j = parseJSON("{}");
	    }
	}



	void load(){
		// load db contents
		File file = File(db, "r");
	    j = parseJSON(file.readln());
	}



	void save(){
		// save 
		File file = File(db, "w+");
		file.write(j);
		file.close();
		load(); // load with the new objects
	}



	string get(string key){
		// return the value of specifiec key
		if(havekey(key)){
			if(j[key].type == JSON_TYPE.ARRAY) {
			   // case is array, return an array of values
				return to!string((j[key].array));
			}else{
				return j[key].str;
			}
		} 
		else{
			throw new Exception("Error: key not exists");
		}			
	}



	void set(string key, string value){
		// set value to specifiec key
        if(!havekey(key)){
        	// case key not exists
        	j.object[key] = value;
        	save();
        }else{

        	if(j[key].type == JSON_TYPE.ARRAY) {
        		// check if already exists 
        		foreach(Key; j[key].array){
        			if(Key.str == value){
        				throw new Exception("Error: value already exists exists");
        			}
        		}

			    JSONValue([j[key].array ~= JSONValue(value)]);
				save();
			}else{
				j.object[key] = JSONValue([j[key].str, value]);
				save();	
			}
        }
	}



	void update(string key, string value, string newvalue = ""){
		// update an already existed key value with new value
		bool VAalueExists;
		int line = 0;

		if(havekey(key)){
			// case json array 
			if(j[key].type == JSON_TYPE.ARRAY) {
				foreach(Key; j[key].array)
				{   
					if (Key.str == value){
						VAalueExists = true;
						break;
					}

					line ++;
				}

				if(VAalueExists){
					j[key][line].str = newvalue;
					save();
				}
			    else{
					throw new Exception("Error: Unable to update value wich not exists");
				}
			}else{
				j[key].str = value;
				save();
			}			
		}
		else{
			throw new Exception("Error: Unable to update key wich not already exists");
		}	
	}



	string[] getkeys(){
		// get keys 
		return(j.object.keys);
	}



	int countkeys(){
		// return the lenght of databae keys
		return to!int(j.object.keys.length);
	}



	ulong count(string key){
		if(havekey(key)){
			// case json array 
			if(j[key].type == JSON_TYPE.ARRAY) {
				return j[key].array.length;
			}
		}
		return 0;
	}



	int getsize(){
		// return database size in bytes
		if(exists(db)){
			return to!int(getSize(db));
		} else{
			throw new Exception("Error: Unable to get database size, database not exists");
		}
	}



	void drop(){
		// Drop database
		if(exists(db)){
			remove(db);
		} else{
			throw new Exception("Error: Unable to drop a non-existed database");
		}
	}



	bool havekey(string key){
		// return true if key exists false if not
		return((key in j) != null);
	}



	bool havevalue(string key, string value){
		if(havekey(key)){
			if(j[key].type == JSON_TYPE.ARRAY){
				foreach(Key; j[key].array)
				{ 
					if (Key.str == value){
						return true;
					}
				}
                
				return false;
			}

			else{

				if(j[key].str == value){
					return true;
				}
				return false;
			}
		}

		return false;
	}
}
