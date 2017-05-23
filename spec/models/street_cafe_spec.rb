require 'rails_helper'

describe StreetCafe do
  context 'aggregate functions' do
    it 'computes the total number of chairs' do
      StreetCafe.create(number_of_chairs: 3)
      StreetCafe.create(number_of_chairs: 2)
      StreetCafe.create(number_of_chairs: 2)
      expect(StreetCafe.total_number_of_chairs).to eq 7
    end

    it 'sums the number of chairs by post code' do
      StreetCafe.create(number_of_chairs: 3, post_code: "ls1")
      StreetCafe.create(number_of_chairs: 4, post_code: "ls1")
      StreetCafe.create(post_code: "ls3", number_of_chairs: 11)
      expect(StreetCafe.sum_of_chairs_in_post_code).to eq({
          'ls1' => 7,
          'ls3' => 11
        })
    end

    it 'sums the number of chairs for a post code' do
      StreetCafe.create(number_of_chairs: 3, post_code: "ls1")
      StreetCafe.create(number_of_chairs: 4, post_code: "ls1")
      StreetCafe.create(post_code: "ls3", number_of_chairs: 11)
      expect(StreetCafe.sum_of_chairs_for_post_code('ls1')).to eq(7)
    end

    it 'gets the percent of number of chairs per post code' do
      StreetCafe.create(number_of_chairs: 3, post_code: "ls1")
      StreetCafe.create(number_of_chairs: 4, post_code: "ls1")
      StreetCafe.create(post_code: "ls3", number_of_chairs: 11)
      expect(StreetCafe.percent_of_chairs_per_post_code('ls1')).to eq('38%')
    end

    it 'gets name of the place with the most chairs in post code' do
      StreetCafe.create(number_of_chairs: 3, post_code: "ls1", cafe_name: "George's Cafe")
      StreetCafe.create(number_of_chairs: 4, post_code: "ls1", cafe_name: "Ben's Cafe")
      expect(StreetCafe.name_with_most_chairs_per_post_code('ls1')).to eq('Ben\'s Cafe')
    end

    it 'gets number of chairs in the place with the max number of chairs' do
      StreetCafe.create(number_of_chairs: 3, post_code: "ls1", cafe_name: "George's Cafe")
      StreetCafe.create(number_of_chairs: 4, post_code: "ls1", cafe_name: "Ben's Cafe")
      expect(StreetCafe.max_chairs_in_post_code('ls1')).to eq(4)
    end

    it 'returns the average number of chairs for a post code' do
      StreetCafe.create(number_of_chairs: 50, post_code: "ls1", cafe_name: "George's Cafe")
      StreetCafe.create(number_of_chairs: 150, post_code: "ls1", cafe_name: "Ben's Cafe")
      expect(StreetCafe.average_chairs_for_post_code('ls1')).to eq(100)
    end

    it 'returns the average number of chairs for a post code as a decimal' do
      StreetCafe.create(number_of_chairs: 2, post_code: "ls2", cafe_name: "George's Cafe")
      StreetCafe.create(number_of_chairs: 20, post_code: "ls1", cafe_name: "George's Cafe")
      StreetCafe.create(number_of_chairs: 27, post_code: "ls1", cafe_name: "Ben's Cafe")
      expect(StreetCafe.average_chairs_for_post_code('ls1')).to eq(23.5)
    end
  end
  context 'aggregate by category' do
    it 'returns the total number of places given a category as a string' do
      StreetCafe.create(number_of_chairs: 2, category: "ls1 small")
      StreetCafe.create(number_of_chairs: 6, category: "ls1 small")
      StreetCafe.create(number_of_chairs: 2, category: "ls1 med")
      expect(StreetCafe.total_num_of_places_in_category('ls1 small')).to eq(2)
    end

    it 'returns the total number of places given a category as a symbol' do
      StreetCafe.create(number_of_chairs: 2, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 6, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 2, category: "ls1_med")
      expect(StreetCafe.total_num_of_places_in_category(:ls1_small)).to eq(2)
    end

    it 'returns the total number of chairs given a category as a string' do
      StreetCafe.create(number_of_chairs: 2, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 6, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 2, category: "ls1_med")
      expect(StreetCafe.total_num_of_chairs_in_category('ls1_small')).to eq(8)
    end

    it 'returns the total number of chairs given a category as a symbol' do
      StreetCafe.create(number_of_chairs: 2, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 6, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 2, category: "ls1_med")
      expect(StreetCafe.total_num_of_chairs_in_category(:ls1_small)).to eq(8)
    end

    it 'returns total number of chairs and places per category' do
      StreetCafe.create(number_of_chairs: 2, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 6, category: "ls1_small")
      StreetCafe.create(number_of_chairs: 2, category: "ls1_med")
      expect(StreetCafe.total_num_of_chairs_and_places_per_category).to match_array( # looks for the things that we want in there and doesn't matter the order
        [
          {category: 'ls1_small', num_places: 2, num_chairs: 8},
          {category: 'ls1_med', num_places: 1, num_chairs: 2}
        ]
      )
      # expect(StreetCafe.total_num_of_chairs_and_places_per_category).to eq(
      #   {
      #     ls1_small: {num_places: 2, num_chairs: 8},
      #     ls1_med: {num_places: 1, num_chairs: 2}
      #   }
      #
      # )
    end

  end
end
