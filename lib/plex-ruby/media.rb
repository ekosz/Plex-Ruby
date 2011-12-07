module Plex
  class Media
    attr_reader :video, :id, :durration, :bitrate, :aspect_ratio, :audio_channels,
      :audio_codec, :video_codec, :video_resolution, :container, :video_frame_rate,
      :parts

    def initialize(video, id, du, br, ar, aco, auc, vc, vr, co, vfr, parts)
      @video            = video
      @id               = id
      @durration        = du
      @bitrate          = br
      @aspect_ratio     = ar
      @audio_channels   = ac
      @audio_codec      = aco
      @video_codec      = vc
      @video_resolution = vr
      @container        = co
      @video_frame_rate = vfr
      @parts            = parts
    end

    def self.build_from_xml(video, xml)
      new()
    end

  end
end
