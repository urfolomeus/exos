module Metadata
  module XYZ

    # Caption content varies with target.kind
    def self.iptc_caption_from(target)
      caption = ""
      if target.kind == Target::BIRTHDAY
        caption << "#{target.age} years"
        caption << "\n#{target.title}"
        caption << "\n#{target.body}"
      elsif target.kind == Target::WEDDING
        caption << "#{target.body}"
        caption << "\n#{target.title}"
      elsif target.kind == Target::ANNIVERSARY
        caption << "#{target.body}"
        caption << "\n#{target.title}"
      elsif target.kind == Target::FATHERSDAY
        caption << "#{target.title}"
        caption << "\n#{target.body}"
      elsif target.kind == Target::MOTHERSDAY
        caption << "#{target.title}"
        caption << "\n#{target.body}"
      elsif target.kind == Target::VALENTINES_DAY
        caption << "#{target.title}"
        caption << "\n#{target.body}"
      elsif target.kind == Target::CHRISTMAS
        caption << "#{target.title}"
        caption << "\n#{target.title}"
        caption << "\n#{target.body}"
      else
        # This part should never execute
        logger.error "  Created caption for unknown target kind. This is should never happen."
        caption << "#{target.title}"
        caption << "\n#{target.body}"
      end
      caption
    end

  end

end
