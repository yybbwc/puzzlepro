local target_name = "opus"
local dir_path = os.scriptdir() .. "/" .. target_name .. "/"
target(target_name)
do
  set_kind("shared")
  add_rules("lib_name")
  do
    local k1 = {}
    k1[#k1 + 1] = "DISABLE_DEBUG_FLOAT"
    k1[#k1 + 1] = "DLL_EXPORT"
    k1[#k1 + 1] = "ENABLE_HARDENING"
    k1[#k1 + 1] = "HAVE_LRINT"
    k1[#k1 + 1] = "HAVE_LRINTF"
    k1[#k1 + 1] = "OPUS_BUILD"
    k1[#k1 + 1] = "VAR_ARRAYS"
    k1[#k1 + 1] = "opus_EXPORTS"
    k1[#k1 + 1] = "HAVE_CONFIG_H"
    for i = 1, #k1 do
      add_defines(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path
    k1[#k1 + 1] = dir_path .. "celt/"
    k1[#k1 + 1] = dir_path .. "silk/"
    k1[#k1 + 1] = dir_path .. "silk/float/"
    for i = 1, #k1 do
      add_includedirs(k1[i])
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "include/"
    for i = 1, #k1 do
      add_includedirs(k1[i], { public = true })
    end
  end
  do
    local k1 = {}
    k1[#k1 + 1] = dir_path .. "src/opus.c"
    k1[#k1 + 1] = dir_path .. "src/opus_decoder.c"
    k1[#k1 + 1] = dir_path .. "src/opus_encoder.c"
    k1[#k1 + 1] = dir_path .. "src/extensions.c"
    k1[#k1 + 1] = dir_path .. "src/opus_multistream.c"
    k1[#k1 + 1] = dir_path .. "src/opus_multistream_encoder.c"
    k1[#k1 + 1] = dir_path .. "src/opus_multistream_decoder.c"
    k1[#k1 + 1] = dir_path .. "src/repacketizer.c"
    k1[#k1 + 1] = dir_path .. "src/opus_projection_encoder.c"
    k1[#k1 + 1] = dir_path .. "src/opus_projection_decoder.c"
    k1[#k1 + 1] = dir_path .. "src/mapping_matrix.c"
    k1[#k1 + 1] = dir_path .. "src/analysis.c"
    k1[#k1 + 1] = dir_path .. "src/mlp.c"
    k1[#k1 + 1] = dir_path .. "src/mlp_data.c"
    k1[#k1 + 1] = dir_path .. "silk/CNG.c"
    k1[#k1 + 1] = dir_path .. "silk/code_signs.c"
    k1[#k1 + 1] = dir_path .. "silk/init_decoder.c"
    k1[#k1 + 1] = dir_path .. "silk/decode_core.c"
    k1[#k1 + 1] = dir_path .. "silk/decode_frame.c"
    k1[#k1 + 1] = dir_path .. "silk/decode_parameters.c"
    k1[#k1 + 1] = dir_path .. "silk/decode_indices.c"
    k1[#k1 + 1] = dir_path .. "silk/decode_pulses.c"
    k1[#k1 + 1] = dir_path .. "silk/decoder_set_fs.c"
    k1[#k1 + 1] = dir_path .. "silk/dec_API.c"
    k1[#k1 + 1] = dir_path .. "silk/enc_API.c"
    k1[#k1 + 1] = dir_path .. "silk/encode_indices.c"
    k1[#k1 + 1] = dir_path .. "silk/encode_pulses.c"
    k1[#k1 + 1] = dir_path .. "silk/gain_quant.c"
    k1[#k1 + 1] = dir_path .. "silk/interpolate.c"
    k1[#k1 + 1] = dir_path .. "silk/LP_variable_cutoff.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF_decode.c"
    k1[#k1 + 1] = dir_path .. "silk/NSQ.c"
    k1[#k1 + 1] = dir_path .. "silk/NSQ_del_dec.c"
    k1[#k1 + 1] = dir_path .. "silk/PLC.c"
    k1[#k1 + 1] = dir_path .. "silk/shell_coder.c"
    k1[#k1 + 1] = dir_path .. "silk/tables_gain.c"
    k1[#k1 + 1] = dir_path .. "silk/tables_LTP.c"
    k1[#k1 + 1] = dir_path .. "silk/tables_NLSF_CB_NB_MB.c"
    k1[#k1 + 1] = dir_path .. "silk/tables_NLSF_CB_WB.c"
    k1[#k1 + 1] = dir_path .. "silk/tables_other.c"
    k1[#k1 + 1] = dir_path .. "silk/tables_pitch_lag.c"
    k1[#k1 + 1] = dir_path .. "silk/tables_pulses_per_block.c"
    k1[#k1 + 1] = dir_path .. "silk/VAD.c"
    k1[#k1 + 1] = dir_path .. "silk/control_audio_bandwidth.c"
    k1[#k1 + 1] = dir_path .. "silk/quant_LTP_gains.c"
    k1[#k1 + 1] = dir_path .. "silk/VQ_WMat_EC.c"
    k1[#k1 + 1] = dir_path .. "silk/HP_variable_cutoff.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF_encode.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF_VQ.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF_unpack.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF_del_dec_quant.c"
    k1[#k1 + 1] = dir_path .. "silk/process_NLSFs.c"
    k1[#k1 + 1] = dir_path .. "silk/stereo_LR_to_MS.c"
    k1[#k1 + 1] = dir_path .. "silk/stereo_MS_to_LR.c"
    k1[#k1 + 1] = dir_path .. "silk/check_control_input.c"
    k1[#k1 + 1] = dir_path .. "silk/control_SNR.c"
    k1[#k1 + 1] = dir_path .. "silk/init_encoder.c"
    k1[#k1 + 1] = dir_path .. "silk/control_codec.c"
    k1[#k1 + 1] = dir_path .. "silk/A2NLSF.c"
    k1[#k1 + 1] = dir_path .. "silk/ana_filt_bank_1.c"
    k1[#k1 + 1] = dir_path .. "silk/biquad_alt.c"
    k1[#k1 + 1] = dir_path .. "silk/bwexpander_32.c"
    k1[#k1 + 1] = dir_path .. "silk/bwexpander.c"
    k1[#k1 + 1] = dir_path .. "silk/debug.c"
    k1[#k1 + 1] = dir_path .. "silk/decode_pitch.c"
    k1[#k1 + 1] = dir_path .. "silk/inner_prod_aligned.c"
    k1[#k1 + 1] = dir_path .. "silk/lin2log.c"
    k1[#k1 + 1] = dir_path .. "silk/log2lin.c"
    k1[#k1 + 1] = dir_path .. "silk/LPC_analysis_filter.c"
    k1[#k1 + 1] = dir_path .. "silk/LPC_inv_pred_gain.c"
    k1[#k1 + 1] = dir_path .. "silk/table_LSF_cos.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF2A.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF_stabilize.c"
    k1[#k1 + 1] = dir_path .. "silk/NLSF_VQ_weights_laroia.c"
    k1[#k1 + 1] = dir_path .. "silk/pitch_est_tables.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler_down2_3.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler_down2.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler_private_AR2.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler_private_down_FIR.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler_private_IIR_FIR.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler_private_up2_HQ.c"
    k1[#k1 + 1] = dir_path .. "silk/resampler_rom.c"
    k1[#k1 + 1] = dir_path .. "silk/sigm_Q15.c"
    k1[#k1 + 1] = dir_path .. "silk/sort.c"
    k1[#k1 + 1] = dir_path .. "silk/sum_sqr_shift.c"
    k1[#k1 + 1] = dir_path .. "silk/stereo_decode_pred.c"
    k1[#k1 + 1] = dir_path .. "silk/stereo_encode_pred.c"
    k1[#k1 + 1] = dir_path .. "silk/stereo_find_predictor.c"
    k1[#k1 + 1] = dir_path .. "silk/stereo_quant_pred.c"
    k1[#k1 + 1] = dir_path .. "silk/LPC_fit.c"
    k1[#k1 + 1] = dir_path .. "celt/bands.c"
    k1[#k1 + 1] = dir_path .. "celt/celt.c"
    k1[#k1 + 1] = dir_path .. "celt/celt_encoder.c"
    k1[#k1 + 1] = dir_path .. "celt/celt_decoder.c"
    k1[#k1 + 1] = dir_path .. "celt/cwrs.c"
    k1[#k1 + 1] = dir_path .. "celt/entcode.c"
    k1[#k1 + 1] = dir_path .. "celt/entdec.c"
    k1[#k1 + 1] = dir_path .. "celt/entenc.c"
    k1[#k1 + 1] = dir_path .. "celt/kiss_fft.c"
    k1[#k1 + 1] = dir_path .. "celt/laplace.c"
    k1[#k1 + 1] = dir_path .. "celt/mathops.c"
    k1[#k1 + 1] = dir_path .. "celt/mdct.c"
    k1[#k1 + 1] = dir_path .. "celt/modes.c"
    k1[#k1 + 1] = dir_path .. "celt/pitch.c"
    k1[#k1 + 1] = dir_path .. "celt/celt_lpc.c"
    k1[#k1 + 1] = dir_path .. "celt/quant_bands.c"
    k1[#k1 + 1] = dir_path .. "celt/rate.c"
    k1[#k1 + 1] = dir_path .. "celt/vq.c"
    k1[#k1 + 1] = dir_path .. "silk/float/apply_sine_window_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/corrMatrix_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/encode_frame_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/find_LPC_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/find_LTP_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/find_pitch_lags_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/find_pred_coefs_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/LPC_analysis_filter_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/LTP_analysis_filter_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/LTP_scale_ctrl_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/noise_shape_analysis_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/process_gains_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/regularize_correlations_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/residual_energy_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/warped_autocorrelation_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/wrappers_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/autocorrelation_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/burg_modified_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/bwexpander_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/energy_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/inner_product_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/k2a_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/LPC_inv_pred_gain_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/pitch_analysis_core_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/scale_copy_vector_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/scale_vector_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/schur_FLP.c"
    k1[#k1 + 1] = dir_path .. "silk/float/sort_FLP.c"
    for i = 1, #k1 do
      add_files(k1[i])
    end
  end
  before_build(function(target)
    os.cd(dir_path)
    if os.exists("config.h") then
    else
      do
        local k1 = {}
        k1[#k1 + 1] = "cmake ."
        for i = 1, #k1 do
          os.exec(k1[i])
        end
      end
    end
  end)
end
