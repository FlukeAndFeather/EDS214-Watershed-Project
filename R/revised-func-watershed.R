#' Title
#'
#' @param focal_date # reference date, in numbers
#' @param dates # vector of sample dates
#' @param conc # vector of ions quantity, in numbers
#' @param win_size_wks # time interval, in weeks
#'
#' @returns
#' @export
#'
#' @examples 
#' mutate(nitrate_N = sapply(sample_date, 
#'                           moving_average,
#'                           dates = sample_date, 
#'                           conc = no3_n, 
#'                           win_size_wks = 9))
#' 
moving_average <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc, na.rm = TRUE)
  
  return(result)
}