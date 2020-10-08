def my_array_uniq(numberArray)
    newNumberArray = []
    numberArray.map do |n|
      if newNumberArray.include? n
        next
      else
        newNumberArray.push(n)
      end
    end
    return newNumberArray
end

# def my_array_uniq(numberArray)
#   return numberArray | numberArray
# end