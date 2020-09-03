require_relative 'station'
require_relative 'route'
require_relative 'train'

train_vulkan = Train.new("Вулкан", "Пассажирский", 8)
train_vulkan2 = Train.new("Вулкан2", "Грузовой", 8)

station_riga = Station.new("Рига")
station_paris = Station.new("Париж")
station_bremen = Station.new("Бремен")

route_riga_paris = Route.new(station_riga, station_paris)
route_riga_paris.add(station_bremen)
route_riga_paris.list

train_vulkan.route = route_riga_paris
train_vulkan.speed_up

train_vulkan.goto_next_station
train_vulkan.goto_next_station