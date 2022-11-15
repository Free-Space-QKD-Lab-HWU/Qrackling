%% tests
clear all
close all

extrema = @(array) [min(array), max(array)];
range = @(x_arr, y_arr, ratio) sum( fliplr( x_arr( extrema( ...
                    find(y_arr > ratio*max(y_arr))) + [-1, 1])) .* [1, -1]);
fwhm = @(x_arr, y_arr) range(x_arr, y_arr, 0.5);
integr = @(x_arr, y_arr, lb, ub) sum(y_arr((x_arr > lb) & (x_arr < ub)));

wvl_central = 850;
window = 100;
width = 10;
mpn = 0.5;
N = 2^12;
[wvl, intens] = gaussian_spectra(wvl_central, window, width, mpn, N);

txt = ['$\lambda_{central} = $', ' ', num2str(wvl_central), 'nm', newline, ...
       '$\bar{n}_{ph} = $ ', num2str(mpn), newline, ...
       '$\int{g\left(\lambda\right)} = $', ' ', num2str(sum(intens)), newline, ...
       '$\bar{n}_{ph} \equiv \int{g\left(\lambda\right)}$'];

figure
plot(wvl, intens)
text((wvl_central - (window/2))*1.01, max(intens) / 2, txt, ...
     'interpreter', 'latex', 'fontsize', 18)



fwhm(wvl, intens)
range(wvl, intens, 1/exp(1))

disp([mpn, sum(intens(intens > 0))])
disp(integr(wvl, intens, 840, 850))

N = 2^10;
[wvl, intens] = gaussian_spectra(wvl_central, window, width, mpn, N);

txt = ['$\lambda_{central} = $', ' ', num2str(wvl_central), 'nm', newline, ...
       '$\bar{n}_{ph} = $ ', num2str(mpn), newline, ...
       '$\int{g\left(\lambda\right)} = $', ' ', num2str(sum(intens)), newline, ...
       '$\bar{n}_{ph} \equiv \int{g\left(\lambda\right)}$'];

figure
plot(wvl, intens)
text((wvl_central - (window/2))*1.01, max(intens) / 2, txt, ...
     'interpreter', 'latex', 'fontsize', 18)


fwhm(wvl, intens)
range(wvl, intens, 1/exp(1))

disp([mpn, sum(intens(intens > 0))])
disp(integr(wvl, intens, 840, 850))
