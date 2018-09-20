class Object
  def meta_def name, &blk
    (class << self; self; end).instance_eval do
      define_method(name, &blk)
    end
  end
end

class String
  def slugize
    self.downcase.gsub(/&/, 'and').gsub(/(\s+)|\./, '-').gsub(/[^a-z0-9\-_]/, '')
  end

  def humanize
    self.capitalize.gsub(/[-_]+/, ' ')
  end

  if RUBY_VERSION < "1.9"
    def bytesize
      size
    end
  end
end

class Date
  # This check is for people running Toto with ActiveSupport, avoid a collision
  unless respond_to? :iso8601
    # Return the date as a String formatted according to ISO 8601.
    def iso8601
      ::Time.utc(year, month, day, 0, 0, 0, 0).iso8601
    end
  end
end
