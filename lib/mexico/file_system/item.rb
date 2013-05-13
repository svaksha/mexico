# This file is part of the MExiCo gem.
# Copyright (c) 2012, 2013 Peter Menke, SFB 673, Universität Bielefeld
# http://www.sfb673.org
#
# MExiCo is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# MExiCo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with MExiCo. If not, see
# <http://www.gnu.org/licenses/>.

# The basic data unit object.
class Mexico::FileSystem::Item

  include ::ROXML
  xml_name 'I'

  xml_accessor :identifier, :from => '@id'

  # @todo compound links (later)

  # collection of Mexico::FileSystem::ItemLink
  xml_accessor :item_links,     :as => [Mexico::FileSystem::ItemLink],     :from => "Links/ItemLink"

  # collection of Mexico::FileSystem::LayerLink
  xml_accessor :layer_links,    :as => [Mexico::FileSystem::LayerLink],    :from => "Links/LayerLink"

  # collection of Mexico::FileSystem::PointLink
  xml_accessor :point_links,    :as => [Mexico::FileSystem::PointLink],    :from => "Links/PointLink"

  # collection of Mexico::FileSystem::IntervalLink
  xml_accessor :interval_links, :as => [Mexico::FileSystem::IntervalLink], :from => "Links/IntervalLink"

  # collection of Mexico::FileSystem::Data
  xml_accessor :data, :as => Mexico::FileSystem::Data, :from => "Data"

  # This method attempts to link objects from other locations of the XML/object tree
  # into position inside this object, by following the xml ids given in the
  # appropriate fields of this class.
  def after_parse
    # store self
    ::Mexico::FileSystem::ToeDocument.store(self.identifier, self)

    [item_links,layer_links,point_links,interval_links].flatten.each do |link|
      link.item = self

      if ::Mexico::FileSystem::ToeDocument.knows?(link.target)
        link.target_object=::Mexico::FileSystem::ToeDocument.resolve(link.target)
      else
        # store i in watch list
        ::Mexico::FileSystem::ToeDocument.watch(link.target, link, :target_object=)
      end

    end

  end

end