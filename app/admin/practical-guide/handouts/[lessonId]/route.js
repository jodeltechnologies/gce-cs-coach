import { readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { requireTeacher } from '../../../../../lib/guards';
import guide from '../../../../../lib/paper3-guide.json';

const lessonIds = new Set(guide.areas.flatMap(area => area.lessons.map(lesson => lesson.id)));

export async function GET(_request, { params }) {
  const { teacher } = await requireTeacher();
  const { lessonId } = await params;
  if (!teacher || !lessonIds.has(lessonId)) {
    return new Response('Handout not found.', { status: 404 });
  }

  const pdf = await readFile(join(process.cwd(), 'assets', 'paper3-handouts', lessonId + '.pdf'));
  const session = lessonId[0].toUpperCase() + lessonId.slice(1).padStart(2, '0');
  return new Response(pdf, {
    headers: {
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename="Paper_3_${session}_Student_Handout.pdf"`,
      'Cache-Control': 'private, no-store',
    },
  });
}
