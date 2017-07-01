require 'csv'
class ExportAndDeleteSmall
  def run
    file = CSV.open('small_ballzz.csv', 'w') do |csv|
      csv << ['id']
      StreetCafe.all.each do |cafe|
        if cafe.category.match 'small'
          csv << [cafe.id]
          # delete will delete just that instance, destroy will delete and cascade it to whereever its at
          cafe.destroy
        end
      end
      csv
    end
    file.close
    'small_ballzz.csv'
  end
end
