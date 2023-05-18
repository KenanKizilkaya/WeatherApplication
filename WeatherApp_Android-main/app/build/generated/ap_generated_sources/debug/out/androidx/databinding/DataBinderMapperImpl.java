package androidx.databinding;

public class DataBinderMapperImpl extends MergedDataBinderMapper {
  DataBinderMapperImpl() {
    addMapper(new kth.kenanmark.weatherapp.DataBinderMapperImpl());
  }
}
