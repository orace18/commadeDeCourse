//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <feda/feda_plugin_c_api.h>
#include <flash_api/flash_api_plugin_c_api.h>
#include <flutter_tts/flutter_tts_plugin.h>
#include <geolocator_windows/geolocator_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FedaPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FedaPluginCApi"));
  FlashApiPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlashApiPluginCApi"));
  FlutterTtsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterTtsPlugin"));
  GeolocatorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GeolocatorWindows"));
}
