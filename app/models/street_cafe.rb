class StreetCafe < ApplicationRecord
  # self.table_name = 'cafes'  overriding the default naming convention
  def self.total_number_of_chairs
    sum(:number_of_chairs) #--> StreetCafe.sum(:number_of_chairs)
  end

  def self.sum_of_chairs_in_post_code
    group(:post_code).sum(:number_of_chairs)
  end

  def self.sum_of_chairs_for_post_code(post_code)
    where(post_code: post_code).sum(:number_of_chairs) # will return specific post-code and then applying the sum
    # sum_of_chairs_in_post_code[post_code] this will go through all and categorize
  end

  def self.average_chairs_for_post_code(post_code)
    cafes_in_post_code = where(post_code: post_code)
    cafes_in_post_code.sum(:number_of_chairs).to_f / cafes_in_post_code.count
  end

  def self.percent_of_chairs_per_post_code(post_code)
    num_balls = sum_of_chairs_for_post_code(post_code).
      to_f / total_number_of_chairs * 100
    num_int = num_balls.to_i
    num_int.to_s + '%'
    # "#{num_int.to_s}%" string interpolation
    # chairs_in_pc / total
  end

  def self.name_with_most_chairs_per_post_code(post_code)
    place_with_max_chairs_in_post_code(post_code).cafe_name
  end

  def self.max_chairs_in_post_code(post_code)
    place_with_max_chairs_in_post_code(post_code).number_of_chairs
  end

  def self.place_with_max_chairs_in_post_code(post_code)
    cafes = where(post_code: post_code)

    # most_chairs = 0
    # cafes.map do |cafe|
    #   if cafe.number_of_chairs > most_chairs
    #     most_chairs = cafe.number_of_chairs
    #   end
    # end
    # cafes.where(number_of_chairs: most_chairs).first.cafe_name

    # sorting and will return last if there is a tie
    # loops through and creates an array with the return values from the loop (remembering which cafe it came from)
    # sorts the array by that value --> number of chairs
    # once sorted, finds corresponding cafes that matched the original value (by memory address)
    # returns original object (cafes active record object) sorted
    sorted = cafes.sort_by do |cafe|
      cafe.number_of_chairs
    end
    # sorted = cafes.sort_by { |cafe| cafe.number_of_chairs }
    sorted.last

    # where(post_code: post_code).order(:number_of_chairs).last.cafe_name
    # where(post_code: post_code).order('number_of_chairs desc').limit(1).first.cafe_name

    # sum_of_chairs_for_post_code(post_code)
    # we need all cafes in a post code
    # find cafe with most chairs
    # return name of that cafe --> cafe.name
  end

  def self.total_num_of_places_in_category(category)
    group(:category).count(:id)[category.to_s]
  end

  def self.total_num_of_chairs_in_category(category)
    # group(:category).sum(:number_of_chairs)[category.to_s]
    group(:category).sum(:number_of_chairs).with_indifferent_access[category]
    # with_indifferent_access knows either the string or symbol rather than doing .to_s or .to_sym
  end

  def self.total_num_of_chairs_and_places_per_category
    # get all categories then get all places and number of chairs for all categories
    categories = StreetCafe.distinct.pluck(:category) # categories = StreetCafe.pluck(:category).uniq

    # for each category, get the nums:
    categories.map do |category|
      num_places = total_num_of_places_in_category(category)
      num_chairs = total_num_of_chairs_in_category(category)

      {category: category, num_places: num_places, num_chairs: num_chairs} # << same as .push() => shovel operator
    end
      # within the class you can use just 'all' or what ever else active record provides
    # street_cafes = all # categories = StreetCafe.pluck(:category).uniq
    #
    # # for each category, get the nums:
    # street_cafes.map do |cafe|
    #   num_places = total_num_of_places_in_category(cafe.category)
    #   num_chairs = total_num_of_chairs_in_category(cafe.category)
    #
    #   {category: cafe.category, num_places: num_places, num_chairs: num_chairs} # << same as .push() => shovel operator
    # end

  end
end
