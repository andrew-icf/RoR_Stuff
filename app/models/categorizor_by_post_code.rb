class CategorizorByPostCode
  def categorize_cafes!
    StreetCafe.all.each do |cafe|
      if cafe.post_code == 'LS1'
        if cafe.number_of_chairs < 10
          cafe.category = 'ls1 small'
        elsif cafe.number_of_chairs >= 10 && cafe.number_of_chairs <= 99
          cafe.category = 'ls1 medium'
        elsif cafe.number_of_chairs >= 100
          cafe.category = 'ls1 large'
        end
      elsif cafe.post_code == 'LS2'
        average_chairs_for_ls2 = StreetCafe.average_chairs_for_post_code('LS2')
        if cafe.number_of_chairs < average_chairs_for_ls2
          cafe.category = 'ls2 small'
        elsif cafe.number_of_chairs > average_chairs_for_ls2
          cafe.category = 'ls2 large'
        end
      else
        cafe.category = 'other'
      end
      cafe.save
    end
  end

end
