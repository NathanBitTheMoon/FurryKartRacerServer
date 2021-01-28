// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pkt_receieve(socket, buffer, address){
	buffer_seek(buffer, buffer_seek_start, 0);
	
	message_id = buffer_read(buffer, buffer_u8);
	
	switch(message_id) {
		case 0x01: // Authenticate
			username = buffer_read(buffer, buffer_string);
			
			ds_map_add(obj_server.username_map, socket, username);
			
			buffer_delete(obj_server.buffer);
			obj_server.buffer = buffer_create(1024, buffer_fixed, 1);
			buffer_seek(obj_server.buffer, buffer_seek_start, 0);
			
			// Check if the username is already taken
			if (ds_list_find_index(obj_server.username_list, username) == -1) {
				ds_list_add(obj_server.username_list, username);
				buffer_write(obj_server.buffer, buffer_u8, 0x01); // Username available
				ds_list_add(obj_log.log_list, "[" + address + ":" + username + "] Username available");
			} else {
				buffer_write(obj_server.buffer, buffer_u8, 0xf1); // Username not available
				ds_list_add(obj_log.log_list, "[" + address + ":" + username + "] Username unavailable");
			}
			
			network_send_packet(socket, obj_server.buffer, buffer_tell(obj_server.buffer));
	}
}