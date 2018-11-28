module AssetHelpers

  def webpack_asset_path(asset)
    if precompiled
      asset_path_from_manifest(asset)
    else
      asset_path_on_server(asset)
    end
  end

  def render_webpack_asset(asset)
    if precompiled
      File.read(
        "#{build_path}#{asset_path_from_manifest(asset)}"
      )
    else
      Down.open(asset_path_on_server(asset)).read
    end
  end

  private

  def precompiled
    build?
  end

  def asset_path_from_manifest(asset)
    if (hashed_asset = manifest[asset])
      "/assets/#{hashed_asset}"
    end
  end

  def asset_path_on_server(asset)
    "http://localhost:8080/assets/#{asset}"
  end

  def manifest
    @manifest ||= YAML.load_file(manifest_path)
  end

  def build_path
    ".tmp/dist"
  end

  def manifest_path
    "#{build_path}/assets/asset-manifest.json"
  end
end
