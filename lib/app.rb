require 'json'
#add date class
require 'date'

path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)


# Print today's date
# creating a date time object and converting it to a date object in my local time zone
date_object = DateTime.now.to_date

#Creating a hash to store days of month with special suffix
days_with_special_suffix = {1 => "st", 2 => "nd", 3 => "rd", 31 => "st"}

#pulling all the keys as an array
days_with_special_suffix_array = days_with_special_suffix.keys

#extracting day of month from the date
day_of_month = date_object.day

#ternary operation to determine the correct suffix for a give day of month
suffix = days_with_special_suffix_array.include?(day_of_month) ? days_with_special_suffix[day_of_month] : "th"

#using strftime method to format the date in the following format ex - Sunday, 14th of Apr 2016
puts ""
puts (date_object.strftime("Printed on %A, the %d#{suffix} of %b %Y"))



puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
  # Print the name of the toy

	products_hash["items"].each do |item|
		total_actual_sales = 0
		retail_price = item["full-price"].to_f
		puts "Toy : #{item["title"]}"
		puts "Retail Price: #{retail_price}$"
		num_of_purchases = item["purchases"].count
		total_expected_sales = (num_of_purchases * retail_price)
		puts "Total Number of Purchases : #{num_of_purchases}"
		item["purchases"].each do |purchase|
			total_actual_sales += purchase["price"]
		end
		puts "Total Amount of Sales = #{total_actual_sales}$"
		average_price_toy = total_actual_sales /num_of_purchases
		puts "Average Price of Toy : #{average_price_toy}$"
		average_discount = (average_price_toy  - retail_price).abs
		puts "Average Discount in $: #{average_discount}$"
		puts "Average Discount % : #{(average_discount / retail_price * 100).round(2)}%"
		puts ""
		puts "-----------------------------------------------------------------------------"
		puts ""


	end
  # Print the retail price of the toy

  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price





	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

# create a unique brands array to group all Toys for each brand
uniq_brands = []
products_hash["items"].each do |item|
	uniq_brands.push(item["brand"]) unless uniq_brands.include?(item["brand"])
end

uniq_brands.each do |brand|

	key_brand = {}
	#loop through each brand and populate the key_brand hash with all toys grouped in an array for a specific brand -> key
 	key_brand[brand] = products_hash["items"].select {|item| item["brand"] == brand }

	#initialize variables to be used to keep track of purchases and in stock numbers
  in_stock = 0
	purchases_arr = []

	#loop through the values array of the hash
	key_brand.values.each do |v|
		#foreach hash in the array
		v.each do |a|
			in_stock += a["stock"]
			purchases_arr.push(a["purchases"])
		end
	end

	total_sales = 0
	total_number_toys_sold = 0
	purchases_arr.each do |a|
		a.each do |hash|
			total_sales += hash["price"]
			total_number_toys_sold += 1
		end
	end
	puts ""
	puts "Brand Name: #{brand}"
	puts "#{brand}'s Toys In Stock : #{in_stock} "
	puts "#{brand}'s Average Toy Price : #{(total_sales / total_number_toys_sold).round(2)}$ "
	puts "#{brand}'s Total Sales : #{total_sales.round(2)}$ "
	puts "------------------------------------------------------------------------------------"
	puts ""
end
