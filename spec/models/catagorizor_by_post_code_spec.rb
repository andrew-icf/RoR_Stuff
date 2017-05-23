require 'rails_helper'

describe CategorizorByPostCode do
  context 'LS1 post code' do
    it 'categorize number of chairs under 10 to ls1 small' do
      cafe = StreetCafe.create(number_of_chairs: 9, post_code: 'LS1')
      cafe2 = StreetCafe.create(number_of_chairs: 4, post_code: 'LS1')
      CategorizorByPostCode.new.categorize_cafes!

      expect(cafe.reload.category).to eq('ls1 small')
      expect(cafe2.reload.category).to eq('ls1 small')
    end

    it 'categorize number of chairs 10 to 99 to ls1 medium' do
      cafe = StreetCafe.create(number_of_chairs: 10, post_code: 'LS1')
      cafe2 = StreetCafe.create(number_of_chairs: 99, post_code: 'LS1')
      CategorizorByPostCode.new.categorize_cafes!

      expect(cafe.reload.category).to eq('ls1 medium')
      expect(cafe2.reload.category).to eq('ls1 medium')
    end

    it 'categorize number of chairs over 100 to ls1 large' do
      cafe = StreetCafe.create(number_of_chairs: 101, post_code: 'LS1')
      cafe2 = StreetCafe.create(number_of_chairs: 199, post_code: 'LS1')
      CategorizorByPostCode.new.categorize_cafes!

      expect(cafe.reload.category).to eq('ls1 large')
      expect(cafe2.reload.category).to eq('ls1 large')
    end
  end

  context 'LS2 post code' do
    it 'categorize 50th percentile within ls2 post code' do
      non_post_code_cafe = StreetCafe.create(number_of_chairs: 1, post_code: 'LS1')
      cafe = StreetCafe.create(number_of_chairs: 50, post_code: 'LS2')
      cafe2 = StreetCafe.create(number_of_chairs: 150, post_code: 'LS2')
      CategorizorByPostCode.new.categorize_cafes!

      expect(cafe.reload.category).to eq('ls2 small')
      expect(cafe2.reload.category).to eq('ls2 large')
    end
  end

  context 'all other post code' do
    it 'categorize all other post codes to other' do
      cafe = StreetCafe.create(number_of_chairs: 50, post_code: 'LS3')
      cafe2 = StreetCafe.create(number_of_chairs: 150, post_code: 'DE6')
      CategorizorByPostCode.new.categorize_cafes!

      expect(cafe.reload.category).to eq('other')
      expect(cafe2.reload.category).to eq('other')
    end
  end
end
