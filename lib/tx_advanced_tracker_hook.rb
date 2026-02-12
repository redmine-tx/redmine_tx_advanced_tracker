class TxAdvancedTrackerHook < Redmine::Hook::ViewListener
  include Redmine::I18n
  def view_layouts_base_html_head(context)
    if context[:request].params[:controller] == 'trackers' then
      if context[:request].params[:action] == 'index' then
        trackers = context[:controller].instance_variable_get(:@trackers)
        
        o = <<EOS
        <script>
          $(function() {
            var $table = $('table.trackers');
            if (!$table.length) return;

            var headers = $('<th>#{l(:field_is_in_roadmap)}</th><th>#{l(:field_is_sidejob)}</th><th>#{l(:field_is_bug)}</th><th>#{l(:field_is_patchnote)}</th><th>#{l(:field_is_exception)}</th>');

            // 데이터 준비
            var trackers = #{ trackers.map { |tracker| [
              tracker.is_in_roadmap ? "📌" : "",
              tracker.is_sidejob ? "📎" : "",
              tracker.is_bug ? "🐞" : "",
              tracker.is_patchnote ? "📄" : "",
              tracker.is_exception ? "🚫" : ""
            ] }.to_json };

            // 헤더: 설명(Description) 컬럼 앞에 삽입
            var $descHeader = $table.find('thead th').filter(function() {
              return $(this).text().trim() === '#{l(:field_description)}';
            });
            if ($descHeader.length) {
              $descHeader.before(headers);
            }

            // 바디: td.description 앞에 삽입
            $table.find('tbody tr').each(function(index) {
              var $descCell = $(this).find('td.description');
              if (!$descCell.length) return;
              $descCell.before('<td>'+trackers[index][0]+'</td><td>'+trackers[index][1]+'</td><td>'+trackers[index][2]+'</td><td>'+trackers[index][3]+'</td><td>'+trackers[index][4]+'</td>');
            });
          });
        </script>
EOS
        o
      elsif ['edit', 'new'].include?(context[:request].params[:action]) then
        tracker = context[:controller].instance_variable_get(:@tracker)
        
        o = <<EOS
        <script>
          $(function() {
            // 체크박스 생성
            var checkboxFields = [
              { name: 'is_sidejob', label: '#{l(:field_is_sidejob)}', checked: #{tracker.is_sidejob}},
              { name: 'is_bug', label: '#{l(:field_is_bug)}', checked: #{tracker.is_bug}},
              { name: 'is_patchnote', label: '#{l(:field_is_patchnote)}', checked: #{tracker.is_patchnote}},
              { name: 'is_exception', label: '#{l(:field_is_exception)}', checked: #{tracker.is_exception}}
            ];

            var checkboxHtml = checkboxFields.map(function(field) {
              return '<p>' +
                      '<label for="tracker_' + field.name + '">' + field.label + '</label>' +
                      '<input type="hidden" name="tracker[' + field.name + ']" value="0" />' +
                      '<input type="checkbox" name="tracker[' + field.name + ']" value="1" ' +
                      (field.checked ? 'checked' : '') + 
                      ' id="tracker_' + field.name + '" />' +
                      '</p>';
            }).join('');

            // 체크박스 삽입
            $('p label[for="tracker_is_in_roadmap"]').parent().after(checkboxHtml);
          });
        </script>
EOS
        o
      end
    end
  end
end 
