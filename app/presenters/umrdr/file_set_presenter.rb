module Umrdr
  class FileSetPresenter < ::Hyrax::FileSetPresenter

  	def parent_doi?
  		g =GenericWork.find (self.parent.id)
  		g.doi.present?
    end

  end
end
