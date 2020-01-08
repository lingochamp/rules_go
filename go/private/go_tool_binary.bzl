# Copyright 2017 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def go_tool_binary(name, srcs):
    """Builds a Go program using `go build`.

    This is used instead of `go_binary` for tools that are executed inside
    actions emitted by the go rules. This avoids a bootstrapping problem. This
    is very limited and only supports sources in the main package with no
    dependencies outside the standard library.

    Args:
      name: A unique name for this rule.
      srcs: list of pure Go source files. No cgo allowed.
    """
    #NOTE(yuan): we create a temp dir here to pass go_tool_binary build cause go 1.12+ requires $GOCACHE env variable.
    #TODO(yuan): update rules_go to latest
    gocache = "GOCACHE=$$(cd $$(dirname $(location //go/toolchain:go_tool))/..; mkdir -p .gocache; cd .gocache; pwd)"
    cmd =  " ".join([
            "GOROOT=$$(cd $$(dirname $(location //go/toolchain:go_tool))/..; pwd)",
            gocache,
            "$(location //go/toolchain:go_tool)",
            "build",
            "-o",
            "$@",
        ] + ["$(location %s)" % s for s in srcs])
    native.genrule(
        name = name,
        srcs = srcs + ["//go/toolchain:go_src"],
        outs = [name + "_bin"],
        cmd = cmd,
        executable = True,
        tools = [
            "//go/toolchain",
            "//go/toolchain:go_tool",
        ],
        visibility = ["//visibility:public"],
    )
