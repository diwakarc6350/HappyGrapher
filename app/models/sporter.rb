class Sporter < ApplicationRecord
  belongs_to :country

  def self.sporter_by_country
    clean_maps ={}
    hash_maps = find_by_sql("select c.name as country, count(c.id) as count from sporters s join countries c where s.country_id=c.id group by c.name order by count desc;").map(&:attributes)
    hash_maps.each do |hash_map|
      hash_map.delete('id')
    end
    hash_maps.each do |hash_map|
      clean_maps[hash_map['country']]=hash_map['count']
    end
    return clean_maps
  end

end
