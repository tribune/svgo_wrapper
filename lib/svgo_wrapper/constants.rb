require "set"

class SvgoWrapper
  DEFAULT_TIMEOUT = 60 # seconds

  VALID_PLUGINS = Set[:cleanupAttrs, :cleanupEnableBackground, :cleanupIDs, :cleanupNumericValues, :collapseGroups,
                      :convertColors, :convertPathData, :convertShapeToPath, :convertStyleToAttrs, :convertTransform,
                      :mergePaths, :moveElemsAttrsToGroup, :moveGroupAttrsToElems, :removeComments, :removeDesc,
                      :removeDoctype, :removeEditorsNSData, :removeEmptyAttrs, :removeEmptyContainers, :removeEmptyText,
                      :removeHiddenElems, :removeMetadata, :removeNonInheritableGroupAttrs, :removeRasterImages,
                      :removeTitle, :removeUnknownsAndDefaults, :removeUnusedNS, :removeUselessStrokeAndFill,
                      :removeViewBox, :removeXMLProcInst, :sortAttrs, :transformsWithOnePath].freeze
end
