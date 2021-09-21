# Steps to use mrautomatr (Step 2 - Step 3)

# See details on this website:
# https://bookdown.org/wuzezhen33/mrautomatr/set-up-the-parameters.html

# 2.  Set up the parameters -----------------------------------------------

# follow the instructions on the website and put your Mplus output files in places

# note the naming rules!!!

# fill in the Excel template
# you can download it here: https://github.com/nyuglobalties/mrautomatr/blob/master/inst/templates/input_template.xlsx

# 3. Generate the report --------------------------------------------------

## 3.1 Generate one report by code

path = box_path("Box 3EA Team Folder/For Zezhen/MR automation/NGY1_FA/PSRA")

render_report(
  output_dir = path,
  output_file = "Report_niger_psra.docx",
  parameters = list(
    # set R code print options
    printcode = FALSE,
    printwarning = FALSE,
    storecache = FALSE,

    # set report overall parameters
    template = file.path(path, "input_template_niger_psra.xlsx"),
    set_title = "Niger Year 1 Measurement Report - Preschool Stress Regulation Assessment (PSRA)",
    set_author = "Ha Yeon Kim",

    # select report sections
    item = TRUE,
    descriptive = TRUE,
    ds_plot = TRUE,
    correlation_matrix_lg = TRUE,
    correlation_matrix_bivar = TRUE,
    correlation_matrix_item = FALSE, # BE CAREFUL! This might crash the document.
    efa_screeplot = TRUE,
    cfa_model_fit = TRUE,
    cfa_model_plot = TRUE,
    cfa_model_parameters = TRUE,
    cfa_model_thresholds = FALSE, # default is to mute the thresholds as the table can get very long
    cfa_r2 = TRUE,
    internal_reliability = TRUE,
    summary_item_statistics = TRUE,
    item_total_statistics = TRUE,
    inv_tx = TRUE,
    inv_gender = TRUE,
    inv_age = TRUE,
    inv_lg = TRUE)
)

## 3.2 Generate one report by manually clicking & typing on a web page
render_report_manual(output_file = "Report_niger_psra.docx",
                     output_dir = path)

## get omega manually because of issues with variable naming

get.omega.bywave(
  path = path,
  model = "PSRA1_CFA1a.out"
)

get.omega.bywave(
  path = path,
  model = "PSRA2_CFA1a.out"
)

get.omega.bywave(
  path = path,
  model = "PSRA3_CFA1a.out"
)

get.omega.lg(
  path = path,
  model = "PSRA123_CFA1-i9_Inv_Scalar.out"
)


## 3.3 Generate multiple separate reports with the same set of settings

## I am not covering this in the workshop as you will seldom use this package
## unless you want to mass produce a bunch of reports with the same format
## see details at https://bookdown.org/wuzezhen33/mrautomatr/generate-the-report.html#render_report_multiple


