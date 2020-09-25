def my_first_script_with_args argv
    argv.map do |arg|
        puts arg
    end
end

my_first_script_with_args ARGV