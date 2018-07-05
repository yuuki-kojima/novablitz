json.array! @cards do |card|
  json.id    card.id
  json.name  card.name
  json.image card.image
end
