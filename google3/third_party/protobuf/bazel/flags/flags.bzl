"""Functionality to turn on and off Starlark implementations of proto flags."""

load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

# Maps flag names to their native reference
_FLAG_DEFINITIONS = {
    "protocopt": (
        lambda ctx: getattr(ctx.fragments.proto, "experimental_protoc_opts"),
    ),
    "experimental_proto_descriptor_sets_include_source_info": (
        lambda ctx: getattr(ctx.attr, "_experimental_proto_descriptor_sets_include_source_info_native")[BuildSettingInfo].value,
    ),
    # are we pulling the right value out of here?
    "proto_compiler": (
        lambda ctx: getattr(ctx.attr, "_proto_compiler_native")[BuildSettingInfo].value,
    ),
    "proto_toolchain_for_javalite": (
        lambda ctx: getattr(ctx.attr, "_aspect_proto_toolchain_for_javalite_native"),
    ),
    "proto_toolchain_for_java": (
        lambda ctx: getattr(ctx.attr, "_aspect_java_proto_toolchain"),
    ),
    "proto_toolchain_for_cc": (
        lambda ctx: getattr(ctx.attr, "_aspect_cc_proto_toolchain"),
    ),
    # proto_toolchain_for_j2objc doesn't seem to be used
    "strict_proto_deps": (
        lambda ctx: getattr(ctx.attr, "_strict_proto_deps_native")[BuildSettingInfo].value,
    ),
    "strict_public_imports": (
        lambda ctx: getattr(ctx.attr, "_strict_public_imports_native")[BuildSettingInfo].value,
    ),
    "cc_proto_library_header_suffixes": (
        lambda ctx: getattr(ctx.fragments.proto, "cc_proto_library_header_suffixes"),
    ),
    "cc_proto_library_source_suffixes": (
        lambda ctx: getattr(ctx.fragments.proto, "cc_proto_library_source_suffixes"),
    ),
}

def get_flag_value(ctx, flag_name):
    if getattr(ctx.attr, "_" + flag_name):
        if "toolchain" in flag_name:
            return getattr(ctx.attr, "_" + flag_name)
        else:
            return getattr(ctx.attr, "_" + flag_name)[BuildSettingInfo].value
    elif flag_name in _FLAG_DEFINITIONS.keys():
        return _FLAG_DEFINITIONS[flag_name](ctx)
    else:
        fail("Unknown flag: %s" % flag_name)
