# encoding: utf-8

require 'scrivener'

class Model
  extend Finders
  include Scrivener::Validations

  class << self
    attr_accessor :storage_engine
  end

  def self.defined_models
    @all_models ||= [ ]
  end

  def self.inherited(subclass)
    defined_models << subclass
  end

  def self.storage
    ref = to_reference + 's'
    Model.storage_engine.new(ref)
  end

  def self.default_sort_by
    :name
  end

  def self.all
    storage.all.map do |raw_content|
      self.new(raw_content: raw_content)
    end
  end

  # Manage relations between models

  def self.attribute(name)
    define_method(name) do
      @data[name.to_s]
    end

    attributes << name
  end

  def self.attributes
    @attrs ||= [ ]
  end

  def self.belongs_to(name, model)
    define_method name do
      name = name.to_s
      model = Utils.class_lookup(self.class, model)
      model.first(:name => self.data[name])
    end
  end

  def self.has_many(name, model, reference = to_reference)
    define_method name do
      model = Utils.class_lookup(self.class, model)
      if reference.to_s.end_with?("s")
        model.find_match(:"#{ reference }" => self.name)
      else
        model.find(:"#{ reference }" => self.name)
      end
    end
  end

  def self.to_reference
    self.name.downcase
  end

  attr_reader :content, :data

  attribute :name

  def initialize(opts)
    raise ArgumentError, 'No raw_content given' if opts[:raw_content].nil?

    split_content = split_content_and_meta(opts[:path], opts[:raw_content])
    @content = split_content[:content]
    @data = split_content[:data]
  end

  def attributes
    self.class.attributes
  end

  def split_content_and_meta(path, raw_content)
    content = ''
    data = { }

    begin
      if match = raw_content.match(/^(---\s*\n(.*?)\n?)^(---\s*$\n?)(.*)/m)
        data = YAML.load(match[2])
        content = match[4].strip
      else
        content = raw_content.strip
      end
    rescue Psych::SyntaxError => e
      raise "YAML error while reading #{ path }: #{ e.message }"
    end

    { content: content, data: data }
  end

  def validate
    assert_present :name
  end

  def template
    if @data["template"]
      @data["template"].to_sym
    else
      default_template
    end
  end

  def default_template
    self.class.name.downcase.to_sym
  end

  def ==(other_model)
    meta_equals = self.data == other_model.data
    content_equals = self.content == other_model.content

    meta_equals && content_equals
  end

  def save
    self.class.storage.save(self.serialize)
  end

  def serialize
    <<-EOF
#{ self.data.to_yaml }
---
#{ self.content }
    EOF
  end


end
