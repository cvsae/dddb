// Copyright (c) 2018 CVSC
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import std.conv : to;
import std.stdio;
import std.file;
import std.json;


class ddb {

   	JSONValue j;
	string db;	
	bool autocommit;

	this(string dbfile, bool autoDump=false)
	{
		db = dbfile;
		autocommit = autoDump;
	    // :dbfile database filename
	    if(exists(dbfile))
	    	// already have dbfile load it 
	    	load();
		else
	    	// db not exists, init null db
	    	j = parseJSON("{}");
	}


	void load()
	{
		// load db contents
		File file = File(db, "r");
	    j = parseJSON(file.readln());
	}



	void autoCommit()
	{
		// Write/save the json dump into the file if auto_commit is enabled
		if (autocommit)
			commit();
	}


	void commit()
	{
		// commit 
		File file = File(db, "w+");
		file.write(j);
		file.close();
		load(); // load with the new objects
	}

	
	string get(string key)
	{
		// return the value of specifiec key
		if(havekey(key))
		{
			if(j[key].type == JSONType.ARRAY)
			   // case is array, return an array of values
				return to!string((j[key].array));
			else
				return j[key].str;
		}
		else
			throw new Exception("Error: key not exists");			
	}



	bool set(string key, string value)
	{
		// set value to specifiec key
        if(!havekey(key))
        {
        	// case key not exists
        	j.object[key] = value;
        	autoCommit();
        	return true;
        }
		else {
        	if(j[key].type == JSONType.ARRAY) 
        	{
        		// check if already exists 
        		foreach(Key; j[key].array) 
        		{
        			if(Key.str == value) {
        				return true;
        			}
        		}

			    JSONValue([j[key].array ~= JSONValue(value)]);
				autoCommit();
				return true;
			}
			else {
				writeln("here");
				j.object[key] = JSONValue([j[key].str, value]);
				autoCommit();	
				return true;
			}
        }

        return false;
	}



	bool update(string key, string value, string newvalue = "") 
	{
		// update an already existed key value with new value
		bool ValueExists;
		int line = 0;

		if(havekey(key)) 
		{
			// case json array 
			if(j[key].type == JSONType.ARRAY) 
			{
				foreach(Key; j[key].array) 
				{   
					if (Key.str == value) 
					{
						j[key][line].str = newvalue;
						commit();

						return true;
					}

					line ++;
				}

			}
			else {
				j[key].str = value;
				return true;
			}		
		}
		

		return false;
	}



	string[] getkeys()
	{
		// get keys 
		return(j.object.keys);
	}



	int countkeys()
	{
		// return the lenght of databae keys
		return to!int(j.object.keys.length);
	}



	ulong count(string key)
	{
		if(havekey(key)) 
		{
			// case json array 
			if(j[key].type == JSONType.ARRAY)
				return j[key].array.length;
		}
		return 0;
	}



	int getsize() 
	{
		// return database size in bytes
		if(exists(db))
			return to!int(getSize(db));
		else
			throw new Exception("Error: Unable to get database size, database does not exists.");
	}



	bool drop()
	{
		// Drop database
		if(exists(db))
		{
			remove(db);
		    return true;

		}
			
		else {
			return false;
		}
	}



	bool havekey(string key) 
	{
		// return true if key exists false if not
		return((key in j) != null);
	}



	bool havevalue(string key, string value)
	{
		if(havekey(key)) 
		{
			if(j[key].type == JSONType.ARRAY) 
			{
				foreach(Key; j[key].array) 
				{ 
					if (Key.str == value)
						return true;
				}            
				return false;
			}
			else {
				return j[key].str == value;
			}
		}
		else {
			return false;
		}
	}



	bool remove(string key)
	{
		JSONValue updatedJson;

		if(havekey(key))
		{
			updatedJson = parseJSON("{}");

			foreach (string _key, ref value; j)
			{
	            if (_key != key) 
	            {
	                updatedJson[_key] = value;
	            }
	        }

	        j = updatedJson;
            commit();
	    }

	    return havekey(key) == false;
	}
}
