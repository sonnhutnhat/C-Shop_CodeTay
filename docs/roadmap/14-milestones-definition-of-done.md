## 5. Thứ tự milestone đề xuất

1. **Foundation ready:** TASK-001 đến TASK-021.
2. **Authenticated shell ready:** TASK-022 đến TASK-033.
3. **Retail MVP:** TASK-039 đến TASK-062, TASK-068 đến TASK-080.
4. **Retail complete:** TASK-034 đến TASK-038, TASK-063 đến TASK-075, TASK-082.
5. **F&B enabled:** TASK-085 đến TASK-091 sau khi backend contract sẵn sàng.
6. **Service enabled:** TASK-092 đến TASK-096 sau khi backend contract sẵn sàng.
7. **Production ready:** TASK-097 đến TASK-105.

## 6. Definition of Done áp dụng cho mọi task triển khai

- Scope chỉ đúng một mục tiêu của task; không kèm refactor ngoài phạm vi.
- Dependency đã hoàn tất hoặc được fake qua domain contract, không import tắt layer.
- Code tuân Feature First và dependency rule.
- Không có secret, PII hoặc token trong code/log/fixture.
- `dart format`, analyze và test liên quan đều pass.
- Error/loading/empty state được xử lý nếu task có UI hoặc I/O.
- Public contract và quyết định không hiển nhiên được document.
- Commit message tham chiếu đúng Task ID.
