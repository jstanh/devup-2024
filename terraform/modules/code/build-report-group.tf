resource "aws_codebuild_report_group" "build_report_group" {
  name = "development-build-report-group"
  type = "TEST"

  export_config {
    type = "NO_EXPORT"
  }
}