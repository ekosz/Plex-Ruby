module Plex
  class Video
    
    attr_reader :ratingKey, :key, :studio, :type, :title, :titleSort, :contentRating,
      :summary, :rating, :viewCount, :year, :tagline, :thumb, :art, :duration,
      :originallyAvailableAt, :updatedAt, :media, :genres, :writers, :directors,
      :roles

    def initialize(rk, key, st, ty, tt, ts, cr, sum, rat, vc, ye, tl, th, art, dr,
                   oaa, ua, med, gs, ws, ds, rs)
      @ratingKey              = rk
      @key                    = key
      @studio                 = st
      @type                   = ty
      @title                  = tt
      @titleSort              = ts
      @contentRating          = cr
      @summary                = sum
      @rating                 = rat
      @viewCount              = vc
      @year                   = ye
      @tagline                = tl
      @thumb                  = th
      @art                    = art
      @duration               = dr
      @originallyAvailableAt  = oaa
      @updatedAt              = ua
      @media                  = med
      @genres                 = gs
      @writers                = ws
      @directors              = ds
      @roles                  = rs
    end

    def self.build_from_xml(xml)
      new()
    end

  end
end
