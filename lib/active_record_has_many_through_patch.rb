module ActiveRecordHasManyThroughPatch
  def self.through_options
    through_options = {}

    if options[:source_type]
      through_options[:conditions] = { reflection.foreign_type => options[:source_type] }
    else
      if options[:conditions]
        through_options[:include]    = options[:include] || options[:source]
        through_options[:conditions] = options[:conditions]
      end

      if options.has_key?(:order)
        through_options[:order] = options[:order]
        if options.has_key?(:through) && options.has_key?(:source)
          through_options[:include] = options[:source]
        end
      end
    end 

    through_options
  end
end