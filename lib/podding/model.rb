# encoding: utf-8

require 'scrivener'

class Model
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
    ref = Utils.pluralize(to_reference)
    Model.storage_engine.new(ref)
  end

  def self.default_sort_by
    :name
  end

  def [](name)
    all.first(name: name)
  end

  # convenience wrappers around all()

  def self.first(filters = { })
    all.first(filters)
  end

  def self.find(filters)
    all.find(filters)
  end

  def self.find_match(filters)
    all.find_match(filters)
  end

  def self.all
    results = storage.all.map do |path, raw_document|
      document = Document.new(raw_document)
      self.new(document, { path: path })
    end

    ResultSet.new(results)
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
    define_method(name) do
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

  attr_reader :document, :content, :data

  attribute :name

  def initialize(document, options = {})
    @path = options[:path]
    @document = document
    @content = @document.content
    @data = @document.data
  end

  def attributes
    self.class.attributes
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
    self.document == other_model.document
  end

  def save
    self.class.storage.save(self.name, @document.serialize)
  end

end
