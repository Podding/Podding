# Relation Management

## One to One

### Constraints

- Model1 explicitly **belongs_to_one** Model2 (via the `model2` attribute)
- Model2 implicitly **has_one** Model1

### Model1 Example

```yaml
name: "foo"
model2: "bar"
```

### Generated Model1 Model

```ruby
class Model1

  def model2
    Model2.first(name: data['model2']
  end

end
```

### Model2 Example

```yaml
name: "bar"
```

### Generated Model2 Model

```ruby
class Model2

  def model1
    Model1.first(model2: data['name'])
  end

end

```

## One to Many / Many to One

### Constraints

- An episode explicitly **belongs_to_one** Show (via `show` attribute)
- A show implicitly **has_many** Episodes

### Episode Example

```yaml
name: "rtn-001"
title: "Podcasten im Futur II"
show: "rtn"
```

### Generated Episode Model


```ruby
class Episode

  def show
    # Reference by show name
    Show.first(name: 'rtn')
  end

end

```

### Show Example

```yaml
name: "rtn"
title: "Retinauten"
author: "Retinauten"
```

### Generated Show Model

```ruby
class Show

  def episodes
    Episode.find(show: 'rtn')
  end

end

```

## Many to Many

### Constraints

- An episode explicitly **belongs_to_many** hosts (via `hosts` array)
- A host implicitly **has_and_belongs_to_many** episodes

### Episode Example

```yaml
name: "rtc-s01e03"
title: "Würstchen und Sommer"
show: "rtc"
date: "1.8.2013"
hosts: [chef, marcel]
```

### Generated Episode Model

```ruby
class Episode

  def hosts
    data['hosts'].map do |host_name|
      Host.first(name: host_name)
    end
  end

end
```

### Host Example

```yaml
name: "chef"
full_name: "chef"
twitter_name: "grischder"
```

### Generated Host Model

```ruby
class Host

  def episodes
    Episode.find_match(host: data['name'])
  end

end
```
