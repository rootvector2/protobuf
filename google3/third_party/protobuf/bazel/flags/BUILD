load("@bazel_skylib//rules:common_settings.bzl", "bool_flag", "string_flag", "string_list_flag")

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//visibility:public"],
)

bool_flag(
    name = "experimental_proto_descriptor_sets_include_source_info",
    build_setting_default = False,
    scope = "universal",
)

label_flag(
    name = "proto_compiler",
    build_setting_default = "@bazel_tools//tools/proto:protoc",
    scope = "universal",
)

# TODO: deprecate this flag.
string_flag(
    name = "strict_proto_deps",
    build_setting_default = "error",
    scope = "universal",
    values = [
        "off",
        "warn",
        "error",
        "strict",
        "default",
    ],
)

# TODO: deprecate this flag.
string_flag(
    name = "strict_public_imports",
    build_setting_default = "off",
    scope = "universal",
    values = [
        "off",
        "warn",
        "error",
        "strict",
        "default",
    ],
)
