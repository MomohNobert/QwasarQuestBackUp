require "csv"
require "time"
def my_data_process(data)
    rows = CSV.parse(data, skip_blanks: true)
    rows = rows.map{|row| row.map(&:strip)}
    rows.delete([""])
    new_rows = []
    header_row = []
    rows[0].each do |r|
        header_row << r
    end
    rows[1..rows.length].map do |row|
        new_row = []
        row[0..3].each do |r|
            new_row << r
        end
        new_row << row[4].split("@")[1]
        age = row[5].to_i
        if (age > 1 && age < 20)
            new_row << "1->20"
        elsif (age > 21 && age < 40)
            new_row << "21->40"
        elsif (age > 41 && age < 65)
            new_row << "41->65"
        else
            new_row << "66->99"
        end
        row[6..8].each do |r|
            new_row << r
        end
        time = row[9].split(" ")
        time = Time.parse(time[1])
        if (time >= Time.parse('06:00am') && time <= Time.parse('11:59am'))
            new_row << "morning"
        elsif (time >= Time.parse('12:00pm') && time <= Time.parse('5:59pm'))
            new_row << "afternoon"
        else 
            new_row << "evening"
        end
        new_rows << new_row.join(",")
    end

  gender_array = []
  email_array = []
  age_array = []
  city_array = []
  device_array = []
  order_at_array = []
  final_array = []
  new_rows[0..new_rows.length].map do |row|
    row = row.split(",")
    gender_array << row[0]
    email_array << row[4]
    age_array << row[5]
    city_array << row[6]
    device_array << row[7]
    order_at_array << row[9]
  end

  gender_hash = gender_array.inject(Hash.new(0)) {|hash, beta_element| hash[beta_element] += 1; hash}
  email_hash =  email_array.inject(Hash.new(0)) {|hash, beta_element| hash[beta_element] += 1; hash}
  age_hash = age_array.inject(Hash.new(0)) {|hash, beta_element| hash[beta_element] += 1; hash}
  city_hash = city_array.inject(Hash.new(0)) {|hash, beta_element| hash[beta_element] += 1; hash}
  device_hash = device_array.inject(Hash.new(0)) {|hash, beta_element| hash[beta_element] += 1; hash}
  order_at_hash = order_at_array.inject(Hash.new(0)) {|hash, beta_element| hash[beta_element] += 1; hash}
    
  final_array = {
    header_row[0] => gender_hash,
    header_row[4] => email_hash, 
    header_row[5] => age_hash, 
    header_row[6] => city_hash, 
    header_row[7] => device_hash, 
    header_row[9] => order_at_hash
  }

  print final_array
end


sample = "Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At\nMale,Carl,Wilderman,carl,wilderman_carl@yahoo.com,29,Seattle,Safari iPhone,2,2020-03-06 16:37:56\nMale,Marvin,Lind,marvin,marvin_lind@hotmail.com,77,Detroit,Chrome Android,2,2020-03-02 13:55:51\nFemale,Shanelle,Marquardt,shanelle,marquardt.shanelle@hotmail.com,21,Las Vegas,Chrome,1,2020-03-05 17:53:05\nFemale,Lavonne,Romaguera,lavonne,romaguera.lavonne@yahoo.com,81,Seattle,Chrome,2,2020-03-04 10:33:53\nMale,Derick,McLaughlin,derick,mclaughlin.derick@hotmail.com,47,Chicago,Chrome Android,1,2020-03-05 15:19:48\n"
my_data_process sample