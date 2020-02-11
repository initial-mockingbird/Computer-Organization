##### ---HashTable  implementation---  ####
#
#	HashTable: Register type structure that holds 3 fields:
#
#	-- Hashtable: address (word) which holds the address in which the 
#	structure is hold.
#	
#	-- Header :: Hash_head (see the specification), which is the
#	HashTable header that holds the comparison function and hashing function.
#
#	-- Contents:: Hash_contents (see the specification), which holds a pointer to 
#	 the Hashtable (Array of lists).
#
#