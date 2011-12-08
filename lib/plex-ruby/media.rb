module Plex
  class Media
    attr_reader :id, :durration, :bitrate, :aspect_ratio, :audio_channels,
      :audio_codec, :video_codec, :video_resolution, :container, :video_frame_rate,
      :parts

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Media
    def initialize(node)
      @id               = node.attr('id')
      @durration        = node.attr('durration')
      @bitrate          = node.attr('bitrate')
      @aspect_ratio     = node.attr('aspectRatio')
      @audio_channels   = node.attr('audioChannels')
      @audio_codec      = node.attr('audioCodec')
      @video_codec      = node.attr('videoCodec')
      @video_resolution = node.attr('videoResolution')
      @container        = node.attr('container')
      @video_frame_rate = node.attr('videoFrameRate')

      @parts = node.search("Part").map { |m| Plex::Part.new(m) }
    end

  end
end
