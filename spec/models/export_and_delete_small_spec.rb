require 'rails_helper'
require 'csv'
describe ExportAndDeleteSmall do
  context 'Delete small cafes' do
    it 'only deletes cafes categorized as small, regardless of post_code' do
      cafe = StreetCafe.create(number_of_chairs: 9, post_code: 'LS1')
      cafe2 = StreetCafe.create(number_of_chairs: 4, post_code: 'LS2')
      cafe3 = StreetCafe.create(number_of_chairs: 12, post_code: 'LS2')
      CategorizorByPostCode.new.categorize_cafes!

      expect{ ExportAndDeleteSmall.new.run }.to change(StreetCafe, :count).by -2
      expect(cafe3.reload).to be_present
    end

    it 'only exports cafes categorized as small to a csv file, regardless of post_code' do
      cafe = StreetCafe.create(number_of_chairs: 9, post_code: 'LS1')
      cafe2 = StreetCafe.create(number_of_chairs: 4, post_code: 'LS2')
      cafe3 = StreetCafe.create(number_of_chairs: 12, post_code: 'LS2')
      CategorizorByPostCode.new.categorize_cafes!
      small_cafe_file_name = ExportAndDeleteSmall.new.run
      data = []
      CSV.foreach(small_cafe_file_name, headers: true) do |row|
        data << row['id']
      end
      expect(data).to match_array([cafe.id.to_s, cafe2.id.to_s])
    end
  end
end
