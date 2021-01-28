print_string = "";


for (i = ds_list_size(log_list) - 1; i != 0; i -= 1) {
	print_string += ds_list_find_value(log_list, i) + "\n";
}
print_string += ds_list_find_value(log_list, 0) + "\n";

draw_text_color(10, 10, print_string, 16777215, 16777215, 16777215, 16777215, 255);