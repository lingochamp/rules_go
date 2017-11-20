# Copyright 2014 The Bazel Authors. All rights reserved.
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

load("@io_bazel_rules_go//go/private:mode.bzl", "mode_string")

GoLibrary = provider()
"""See go/providers.rst#GoLibrary for full documentation."""

GoPackage = provider()

GoPath = provider()

GoEmbed = provider()
"""See go/providers.rst#GoEmbed for full documentation."""

GoArchive = provider()
"""See go/providers.rst#GoArchive for full documentation."""

GoArchiveData = provider()

CgoInfo = provider()
GoStdLib = provider()
