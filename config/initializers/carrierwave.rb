module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end

    def sharpen(val)
      manipulate! do |img|
        img.sharpen(val.to_s)
        img = yield(img) if block_given?
        img
      end
    end

  end
end
